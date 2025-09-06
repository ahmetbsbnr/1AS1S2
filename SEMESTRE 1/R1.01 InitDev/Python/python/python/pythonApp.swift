//
//  pythonApp.swift
//  python
//
//  Created by Basbunar Ahmet on 10/9/24.
//

import SwiftUI
import SwiftData
import UniformTypeIdentifiers

@main
struct pythonApp: App {
    var body: some Scene {
        DocumentGroup(editing: .itemDocument, migrationPlan: pythonMigrationPlan.self) {
            ContentView()
        }
    }
}

extension UTType {
    static var itemDocument: UTType {
        UTType(importedAs: "com.example.item-document")
    }
}

struct pythonMigrationPlan: SchemaMigrationPlan {
    static var schemas: [VersionedSchema.Type] = [
        pythonVersionedSchema.self,
    ]

    static var stages: [MigrationStage] = [
        // Stages of migration between VersionedSchema, if required.
    ]
}

struct pythonVersionedSchema: VersionedSchema {
    static var versionIdentifier = Schema.Version(1, 0, 0)

    static var models: [any PersistentModel.Type] = [
        Item.self,
    ]
}
