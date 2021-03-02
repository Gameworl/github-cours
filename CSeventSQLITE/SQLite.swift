//
//  SQLite.swift
//  CSeventSQLITE
//
//  Created by local192 on 02/03/2021.
//

import Foundation
import SQLite3

class SQLite {
    // création de la base et connection
    var dbPtr: OpaquePointer? = nil
    let sqlitePath: String

    init?(path: String){
        sqlitePath = path
        dbPtr = self.openDatabase(path: sqlitePath)
    }
        
    func openDatabase(path: String) -> OpaquePointer {
        var connectdb: OpaquePointer? = nil
        var dbStatus : Int32 = SQLITE_ERROR
        
        dbStatus = sqlite3_open(path, &connectdb)
        
        if dbStatus != SQLITE_OK {
            print("unable to open dataBase. Error: ", dbStatus)
        }
        return connectdb!
    }
    // création d'une table
    func createTable(_ tableName: String, columnsInfo: [String]) -> Int32 {
            var dbStatus: Int32 = SQLITE_ERROR
            
            let sqlCmd: String = "create table if not exists \(tableName) "
                + "(\(columnsInfo.joined(separator: ",")))"
            
            dbStatus = sqlite3_exec(self.dbPtr, String(sqlCmd), nil, nil, nil)
            
            if dbStatus == SQLITE_OK {
                print("Create table sucess")
            }
            return dbStatus
        }
    
    // insert une ligne dans une table
    func insert(_ tableName: String, rowInfo: [String: String]) -> Int32 {
            var dbStatus: Int32 = SQLITE_ERROR
            
            let sqlCmd: String = "insert into \(tableName) "
                + "(\(rowInfo.keys.joined(separator: ",")))"
                + "values (\(rowInfo.values.joined(separator: ",")))"
            
            dbStatus = sqlite3_exec(self.dbPtr, String(sqlCmd), nil, nil, nil)
            
            return dbStatus
        }
    
    let rowCount = 15
    // génére la liste des events
    func fetch(_ tableName: String, cond: String?, sortBy order: String?, offset: Int?) -> OpaquePointer {
            var dbStatus: Int32 = SQLITE_ERROR
            
            var sqlCmd: String = "select * from \(tableName)"
            if let condition = cond {
                sqlCmd += " where \(condition)"
            }
            if let orderBy = order {
                sqlCmd += " order by \(orderBy)"
            }
            sqlCmd += " limit \(rowCount)"
            if let offsetNum = offset {
                sqlCmd += " offset \(offsetNum)"
            }
            
            var statement: OpaquePointer? = nil
            dbStatus = sqlite3_prepare_v2(self.dbPtr, String(sqlCmd),-1,&statement, nil)
            
            return statement!
        }
    // update l'event
    func update(_ tableName: String, cond: String?, rowInfo: [String: String]) -> Int32 {
            
            var dbStatus: Int32 = SQLITE_ERROR
            
            var sqlCmd: String = "update \(tableName) set "
            var info: [String] = []
            for (key, value) in rowInfo {
                info.append("\(key) = \(value)")
            }
            sqlCmd += info.joined(separator: ",")
            if let condition = cond {
                sqlCmd += " where \(condition)"
            }
            
            var statement: OpaquePointer? = nil
            
            dbStatus = sqlite3_prepare_v2(self.dbPtr, String(sqlCmd),-1, &statement, nil)
            if dbStatus == SQLITE_OK && sqlite3_step(statement) == SQLITE_DONE {
                print("Update data sucess")
                return dbStatus
            }
            sqlite3_finalize(statement)
            return dbStatus
        }
    // fonction delete ligne de la table
    func delete(_ tableName: String, cond: String?) -> Int32 {
            var dbStatus: Int32 = SQLITE_ERROR
            
            var sqlCmd: String = "delete from \(tableName)"
            
            if let condition = cond {
                sqlCmd += " where \(condition)"
            }
            
            var statement: OpaquePointer? = nil
            dbStatus = sqlite3_prepare_v2(self.dbPtr, String(sqlCmd), -1, &statement, nil)
            if dbStatus == SQLITE_OK && sqlite3_step(statement) == SQLITE_DONE {
                print("Delete data sucess")
                return dbStatus
            }
            sqlite3_finalize(statement)
            return dbStatus
            
        }
    
    // function delete toute la table
    func deleteAll(_ tableName: String) -> Int32 {
            var dbStatus: Int32 = SQLITE_ERROR
            
            let sqlCmd: String = "delete from \(tableName)"
            
            var statement: OpaquePointer? = nil
            dbStatus = sqlite3_prepare_v2(self.dbPtr, String(sqlCmd), -1, &statement, nil)
            if dbStatus == SQLITE_OK && sqlite3_step(statement) == SQLITE_DONE {
                print("Delete data sucess")
                return dbStatus
            }
            sqlite3_finalize(statement)
            return dbStatus
            
        }
}
