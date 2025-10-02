import ProjectDescription 

public enum TuistEnv {

	///
	public enum Plan: String, CaseIterable {
		case debug = "Debug"
		case staging = "Staging"
		case production = "Production"

		public var configurationName: ConfigurationName {
			ConfigurationName(stringLiteral: rawValue)
		}
	}

	public static let appName: String = Environment.APP_NAME.getString(
		default: "MissingAppName"
	)

	public static let bundleSuffix: String = Environment.BUNDLE_SUFFIX.getString(
		default: "MissingBundleSuffix"
	)

	public static let appSchemes: [Scheme] = {
		return [debugScheme, stagingScheme, productionScheme]
	}()

	//MARK: - Private 
	private static func schemeName(for plan: Plan) -> String {
		return "\(appName)-\(plan.rawValue)"
	}

	private static let debugScheme: Scheme = .scheme(
		name: schemeName(for: .debug),
		shared: true,
		buildAction: .buildAction(
			targets: ["\(appName)"],
			preActions: [debugAction]
		),
		runAction: .runAction(
			configuration: ConfigurationName(
				stringLiteral: TuistEnv.Plan.debug.rawValue
			)
		),
		archiveAction: .archiveAction(
			configuration: ConfigurationName(
				stringLiteral: TuistEnv.Plan.debug.rawValue
			)		
		)		
	)

	private static let stagingScheme: Scheme = .scheme(
		name: schemeName(for: .staging),
		shared: true,
		buildAction: .buildAction(
			targets: ["\(appName)"]
		),
		runAction: .runAction(
			configuration: TuistEnv.Plan.staging.configurationName
		),
		archiveAction: .archiveAction(
			configuration: ConfigurationName(
				stringLiteral: TuistEnv.Plan.staging.rawValue
			)
		)		
	)

	private static let productionScheme: Scheme = .scheme(
		name: schemeName(for: .production),
		shared: true,
		buildAction: .buildAction(
			targets: ["\(appName)"]
		),
		runAction: .runAction(
			configuration: TuistEnv.Plan.production.configurationName
		),
		archiveAction: .archiveAction(
			configuration: ConfigurationName(
				stringLiteral: TuistEnv.Plan.production.rawValue
			)
		)		
	)

	private static let debugAction: ExecutionAction = .executionAction(
		scriptText: "echo Debug", 
		target: "\(appName)"
	)
}