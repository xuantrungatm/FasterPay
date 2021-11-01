//
//  AppInject.swift
//  MyApp
//
//

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        register {
            AuthManager()
        }
        .implements(AuthManagerInterface.self)
        .scope(.application)
        
        register {
            RealmDataBase()
        }
        .implements(RealmDataBaseInterface.self)
        .scope(.application)
    }
}
