<h1>Installation</h1>

<b>Carthage</b>
```
gitHub "4bb3/cassby-sdk-ios"
```
<h1>Usage</h1>

1. In AppDelegate

```

import CassbySDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        CassbySDK.shared.launch(token: YOUR_TOKEN)
        
        return true
    }

```

2. When you want to submit a sale

```

let check = CheckManager(id_branch: ID_BRANCH)
check.addToCheck(name: POSITION_NAME, price: PRICE_IN_KOPS, qty: QTY)
check.addToCheck(name: POSITION_NAME_@, price: PRICE_IN_KOPS, qty: QTY)
check.commit()

```
