import ProjectDescription

extension Project {


	public static func create(
		name: String,
		destinations: Destinations, 
		dependencies: [TargetDependency]
	)-> Project {
		let debugScheme = debugScheme(for: name)
		let stagingScheme = stagingScheme(for: name)
		let productionScheme = productionScheme(for: name)

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
					destinations: destinations,
					product: .app,
					bundleId: "$(BUNDLE_ID)",
					infoPlist: .extendingDefault(with: appInfoPlist),
					resources: ["Resources/**"],
					buildableFolders: ["Sources"],					
					dependencies: dependencies,
					settings: .settings(configurations: appConfigurations)
				)
			],
			schemes: [debugScheme, stagingScheme, productionScheme]
			//schemes: appSchemes(for: name)
		)
	}

	private static var appConfigurations: [Configuration] {
    return [
    	.debug(
        name: "Debug", 
        xcconfig: .relativeToRoot("Configurations/Debug.xcconfig")
    	),
    	.release(
        name: "Release-Staging", 
        xcconfig: .relativeToRoot("Configurations/Staging.xcconfig")
    	),
      .release(
        name: "Release-Production", 
        xcconfig: .relativeToRoot("Configurations/Production.xcconfig")
      )
    ]
	}

	private static func debugScheme(for name: String) -> Scheme {
		return .scheme(
      name: name + "-Debug",
      shared: true,
      buildAction: .buildAction(targets: ["\(name)"]),
      runAction: .runAction(configuration: "Debug")			
		)
	}

	private static func stagingScheme(for name: String) -> Scheme {
		return .scheme(
      name: name + "-Staging",
      shared: true,
      buildAction: .buildAction(targets: ["\(name)"]),
      runAction: .runAction(configuration: "Release-Staging")		
		)
	}

	private static func productionScheme(for name: String) -> Scheme {
		return .scheme(
      name: name + "-Production",
      shared: true,
      buildAction: .buildAction(targets: ["\(name)"]),
      runAction: .runAction(configuration: "Release-Production")		
		)
	}

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
}