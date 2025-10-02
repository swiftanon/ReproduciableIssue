# Issue Summary

## Expected Behavior:
I expect ProjectDescriptionHelpers to help me "not repeat myself". 
This means that I should be able to define debug, staging, production schemes 
once and only once and be able to use them in the appropriate places.

Details: 
According to your documentation, this is the method signature for creating a 
Project:
let project = Project(
    name: String,
    targets: [Target],
    schemes: [Scheme]
)

Therefore, I expect that when this implementation of that signature: 
let project = Project.create(
	name: "Learn",
	destinations: .iOS,
	dependencies: [
	]
)

is used in conjunction with this implementation of a ProjectDescriptionHelper

```
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
		  	automaticSchemesOptions: .disabled
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
		)
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
```

an Xcode Project with these 3 schemes 

- Debug, 
- Release-Staging
- Release-Production

is successfully created.

## Current Behavior

When I ran `just generate-project`, these following errors occur:
1). `The build configuration 'Release-Staging' specified in the 
scheme's run action isn't defined in the project.`
2). `The build configuration 'Release-Production' specified in 
the scheme's run action isn't defined in the project.`


### Steps To Reproduce:
1). Clone this [repo]()
2). cd into repo dir
3). run `just generate-project`