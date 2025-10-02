import ProjectDescription

extension Project {

  private static var appInfoPlist: [String: Plist.Value] {
  	return [
	  	"APP_ENV": "$(APP_ENV",
	  	"APP_NAME": "$(APP_NAME)",
	  	"CFBundleName": "$(APP_NAME)",
	  	"CFBundleDisplayName": "$(BUNDLE_DISPLAY_NAME)",
			"UILaunchStoryboardName": "LaunchScreen.storyboard",	  	
			"UISupportedInterfaceOrientations~iphone": [
			  "UIInterfaceOrientationPortrait"
			]	  	
  	]
  }

  public static func app(
  	name: String,
  	schemes: [Scheme]
  ) -> Project {
  	return Project(
  		name: name,
		  options: .options(
		  	automaticSchemesOptions: .disabled,
		    textSettings: .textSettings(
		    	usesTabs: true, indentWidth: 2, tabWidth: 2
		    )
		  ),	
		  targets: [
		  	.target(
		  		name: name,
		  		destinations: .iOS,
					product: .app,
					bundleId: "$(BUNDLE_ID)",
					infoPlist: .extendingDefault(with: appInfoPlist),
					resources: ["Resources/**"],
					buildableFolders: ["Sources"],
					dependencies: [],
					settings: Settings.appSettings
		  	)
		  ],
		  schemes: schemes	  
  	)
  }
}

