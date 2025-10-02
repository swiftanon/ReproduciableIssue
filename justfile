set dotenv-load := true

# Fail if required .env file is missing
set dotenv-required := true

# Because each line of each recipe is executed
# by a fresh shell, it is not possible to 
# share environment variables between recipes.
# To solve this, we need to explicitly pass the 
# environment variables to the tuist process from 
# within the justfile recipe. The best way to do
# this is to take advantage of the export mechanism
# in just and combine it with the dotenv settings.
export TUIST_APP_NAME := env("APP_NAME")


hello:
		@echo "env(TUIST_APP_NAME): $TUIST_APP_NAME"

# Recipe to generate Xcode project using Tuist. 
# The only entry point for local dev setup.
# Run via `just generate-project`.
generate-project:
  tuist generate		