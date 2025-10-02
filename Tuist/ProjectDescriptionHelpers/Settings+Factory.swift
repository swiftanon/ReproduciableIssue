import ProjectDescription

extension Settings {
	static let appSettings: Settings = {
		.settings(
			base: [
				"SWIFT_VERSION": "5.0"
			],
			configurations: [
	    	.debug(
	        name: ConfigurationName(stringLiteral: TuistEnv.Plan.debug.rawValue), 
	        xcconfig: .relativeToRoot("Configurations/Debug.xcconfig")
	    	),
	    	.release(
	        name: ConfigurationName(stringLiteral: TuistEnv.Plan.staging.rawValue),
	        xcconfig: .relativeToRoot("Configurations/Staging.xcconfig")
	    	),
	      .release(
	        name: ConfigurationName(stringLiteral: TuistEnv.Plan.production.rawValue), 
	        xcconfig: .relativeToRoot("Configurations/Production.xcconfig")
	      )
			]
		)
	}()
}
