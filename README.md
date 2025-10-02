# Issue Summary

## Expected Behavior:
I expect ProjectDescriptionHelpers to help me "not repeat myself". 
This means that I should be able to define `debug, staging, production schemes` 
only once and be able to use them in the appropriate places.

#### Details:
According to your documentation, this is the method signature for creating a 
Project:
```swift
let project = Project(
    name: String,
    targets: [Target],
    schemes: [Scheme]
)
```

Therefore, I expect that when this implementation of that signature: 
```swift
let project = Project.app(
	name: TuistEnv.appName,
	schemes: TuistEnv.appSchemes
)
```
is used in conjunction with this implementation of a ProjectDescriptionHelper

```swift
extension Project {
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
```

an Xcode Project with these 3 schemes 

- Debug, 
- Staging
- Production

is successfully created.

## Current Behavior

When I ran `just generate-project`, these following errors occur:

- `The build configuration 'Staging' specified in the 
scheme's run action isn't defined in the project.`

- `The build configuration 'Production' specified in 
the scheme's run action isn't defined in the project.`


### Steps To Reproduce:

- Clone this [repo](https://github.com/swiftanon/ReproduciableIssue)

- cd into repo dir

- run `just generate-project`