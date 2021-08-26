//import FlyyF

@objc (FlyyPlugin) class FlyyPlugin: CDVPlugin {
    
    @objc(intSdk:) func initSdk(command: CDVInvokedUrlCommand) {
        
        let partnerToken = (command.arguments[0] as? NSObject)?.value(forKey: "partner_token") as? String
        let environment = (command.arguments[1] as? NSObject)?.value(forKey: "environment") as? String
        
        
        
    }
    
}
