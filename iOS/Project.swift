// swift-tools-version: 6.0
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.app(
	name: TuistEnv.appName,
	schemes: TuistEnv.appSchemes
)

print("")
print("")
print("App Config: \(TuistEnv.Plan.allCases.map {$0.rawValue})")
print("")
print("")
print("schemes: \(TuistEnv.appSchemes)")
print("")
print("")