//
//  DaemonView.swift
//  Geranium
//
//  Created by Constantin Clerc on 10/12/2023.
//

import SwiftUI

struct ProcessItem: Identifiable {
    let id = UUID()
    let pid: String
    let procName: String
}

struct DaemonView: View {
    let processes: [ProcessItem]

    init() {
        let rawProcesses = sysctl_ps()
        self.processes = rawProcesses!.compactMap { rawProcess in
            guard let dict = rawProcess as? NSDictionary,
                  let pid = dict["pid"] as? String,
                  let procName = dict["proc_name"] as? String else {
                return nil
            }
            return ProcessItem(pid: pid, procName: procName)
        }
    }

    var body: some View {
        List(processes) { process in
            HStack {
                Text("PID: \(process.pid)")
                Spacer()
                Text("Name: \(process.procName)")
            }
        }
        .navigationTitle("Processes")
    }
}
