// swift-tools-version: 6.0
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.app(
	name: TuistEnv.appName,
	schemes: TuistEnv.appSchemes
)