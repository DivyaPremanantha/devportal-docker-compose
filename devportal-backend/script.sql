-- AUTO-GENERATED FILE.

-- This file is an auto-generated file by Ballerina persistence layer for model.
-- Please verify the generated scripts and execute them against the target DB server.

DROP TABLE IF EXISTS "OrganizationAssets";
DROP TABLE IF EXISTS "ApiImages";
DROP TABLE IF EXISTS "Review";
DROP TABLE IF EXISTS "Subscription";
DROP TABLE IF EXISTS "User";
DROP TABLE IF EXISTS "ApplicationProperties";
DROP TABLE IF EXISTS "IdentityProvider";
DROP TABLE IF EXISTS "AdditionalProperties";
DROP TABLE IF EXISTS "ApiContent";
DROP TABLE IF EXISTS "ThrottlingPolicy";
DROP TABLE IF EXISTS "Organization";
DROP TABLE IF EXISTS "ApiMetadata";
DROP TABLE IF EXISTS "RateLimitingPolicy";
DROP TABLE IF EXISTS "Application";

CREATE TABLE "Application" (
	"appId" VARCHAR(191) NOT NULL,
	"applicationName" VARCHAR(191) NOT NULL,
	"sandBoxKey" VARCHAR(191) NOT NULL,
	"productionKey" VARCHAR(191) NOT NULL,
	"addedAPIs" VARCHAR(191) NOT NULL,
	"idpId" VARCHAR(191) NOT NULL,
	PRIMARY KEY("appId")
);

CREATE TABLE "RateLimitingPolicy" (
	"policyId" VARCHAR(191) NOT NULL,
	"policyName" VARCHAR(191) NOT NULL,
	"policyInfo" VARCHAR(191) NOT NULL,
	PRIMARY KEY("policyId")
);

CREATE TABLE "ApiMetadata" (
	"apiId" VARCHAR(191) NOT NULL,
	"orgId" VARCHAR(191) NOT NULL,
	"apiName" VARCHAR(191) NOT NULL,
	"organizationName" VARCHAR(191) NOT NULL,
	"apiCategory" VARCHAR(191) NOT NULL,
	"openApiDefinition" TEXT NOT NULL,
	"productionUrl" VARCHAR(191) NOT NULL,
	"sandboxUrl" VARCHAR(191) NOT NULL,
	"authorizedRoles" VARCHAR(191),
	"metadata" TEXT NOT NULL,
	PRIMARY KEY("apiId","organizationName")
);

CREATE TABLE "Organization" (
	"orgId" VARCHAR(191) NOT NULL,
	"organizationName" VARCHAR(191) NOT NULL,
	"templateName" VARCHAR(191) NOT NULL,
	"isPublic" BOOLEAN NOT NULL,
	"authenticatedPages" VARCHAR(191) NOT NULL,
	PRIMARY KEY("orgId")
);

CREATE TABLE "ThrottlingPolicy" (
	"policyId" VARCHAR(191) NOT NULL,
	"type" VARCHAR(191) NOT NULL,
	"policyName" VARCHAR(191) NOT NULL,
	"description" VARCHAR(191) NOT NULL,
	"apimetadataApiId" VARCHAR(191) NOT NULL,
	"apimetadataOrganizationName" VARCHAR(191) NOT NULL,
	FOREIGN KEY("apimetadataApiId", "apimetadataOrganizationName") REFERENCES "ApiMetadata"("apiId", "organizationName"),
	PRIMARY KEY("policyId")
);

CREATE TABLE "ApiContent" (
	"contentId" VARCHAR(191) NOT NULL,
	"apiContent" TEXT NOT NULL,
	"apimetadataApiId" VARCHAR(191) NOT NULL,
	"apimetadataOrganizationName" VARCHAR(191) NOT NULL,
	FOREIGN KEY("apimetadataApiId", "apimetadataOrganizationName") REFERENCES "ApiMetadata"("apiId", "organizationName"),
	PRIMARY KEY("contentId")
);

CREATE TABLE "AdditionalProperties" (
	"propertyId" VARCHAR(191) NOT NULL,
	"key" VARCHAR(191) NOT NULL,
	"value" VARCHAR(191) NOT NULL,
	"apimetadataApiId" VARCHAR(191) NOT NULL,
	"apimetadataOrganizationName" VARCHAR(191) NOT NULL,
	FOREIGN KEY("apimetadataApiId", "apimetadataOrganizationName") REFERENCES "ApiMetadata"("apiId", "organizationName"),
	PRIMARY KEY("propertyId")
);

CREATE TABLE "IdentityProvider" (
	"idpID" VARCHAR(191) NOT NULL,
	"id" VARCHAR(191) NOT NULL,
	"name" VARCHAR(191) NOT NULL,
	"type" VARCHAR(191) NOT NULL,
	"issuer" VARCHAR(191) NOT NULL,
	"clientId" VARCHAR(191) NOT NULL,
	"clientSecret" VARCHAR(191) NOT NULL,
	"organizationOrgId" VARCHAR(191) NOT NULL,
	FOREIGN KEY("organizationOrgId") REFERENCES "Organization"("orgId"),
	PRIMARY KEY("idpID")
);

CREATE TABLE "ApplicationProperties" (
	"propertyId" VARCHAR(191) NOT NULL,
	"name" VARCHAR(191) NOT NULL,
	"value" VARCHAR(191) NOT NULL,
	"applicationAppId" VARCHAR(191) NOT NULL,
	FOREIGN KEY("applicationAppId") REFERENCES "Application"("appId"),
	PRIMARY KEY("propertyId")
);

CREATE TABLE "User" (
	"userId" VARCHAR(191) NOT NULL,
	"role" VARCHAR(191) NOT NULL,
	"userName" VARCHAR(191) NOT NULL,
	"applicationAppId" VARCHAR(191) NOT NULL,
	FOREIGN KEY("applicationAppId") REFERENCES "Application"("appId"),
	PRIMARY KEY("userId")
);

CREATE TABLE "Subscription" (
	"subscriptionId" VARCHAR(191) NOT NULL,
	"apiApiId" VARCHAR(191) NOT NULL,
	"apiOrganizationName" VARCHAR(191) NOT NULL,
	FOREIGN KEY("apiApiId", "apiOrganizationName") REFERENCES "ApiMetadata"("apiId", "organizationName"),
	"userUserId" VARCHAR(191) NOT NULL,
	FOREIGN KEY("userUserId") REFERENCES "User"("userId"),
	"organizationOrgId" VARCHAR(191) NOT NULL,
	FOREIGN KEY("organizationOrgId") REFERENCES "Organization"("orgId"),
	"subscriptionPolicyId" VARCHAR(191) UNIQUE NOT NULL,
	FOREIGN KEY("subscriptionPolicyId") REFERENCES "ThrottlingPolicy"("policyId"),
	PRIMARY KEY("subscriptionId")
);

CREATE TABLE "Review" (
	"reviewId" VARCHAR(191) NOT NULL,
	"rating" INT NOT NULL,
	"comment" VARCHAR(191) NOT NULL,
	"apifeedbackApiId" VARCHAR(191) NOT NULL,
	"apifeedbackOrganizationName" VARCHAR(191) NOT NULL,
	FOREIGN KEY("apifeedbackApiId", "apifeedbackOrganizationName") REFERENCES "ApiMetadata"("apiId", "organizationName"),
	"reviewedbyUserId" VARCHAR(191) NOT NULL,
	FOREIGN KEY("reviewedbyUserId") REFERENCES "User"("userId"),
	PRIMARY KEY("reviewId")
);

CREATE TABLE "ApiImages" (
	"imageId" VARCHAR(191) NOT NULL,
	"key" VARCHAR(191) NOT NULL,
	"value" VARCHAR(191) NOT NULL,
	"apimetadataApiId" VARCHAR(191) NOT NULL,
	"apimetadataOrganizationName" VARCHAR(191) NOT NULL,
	FOREIGN KEY("apimetadataApiId", "apimetadataOrganizationName") REFERENCES "ApiMetadata"("apiId", "organizationName"),
	PRIMARY KEY("imageId")
);

CREATE TABLE "OrganizationAssets" (
	"assetId" VARCHAR(191) NOT NULL,
	"pageType" VARCHAR(191) NOT NULL,
	"pageContent" TEXT NOT NULL,
	"organizationOrgId" VARCHAR(191) NOT NULL,
	FOREIGN KEY("organizationOrgId") REFERENCES "Organization"("orgId"),
	PRIMARY KEY("assetId")
);
