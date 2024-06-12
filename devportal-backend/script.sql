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
DROP TABLE IF EXISTS "OrgImages";
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
	PRIMARY KEY("apiId","orgId")
);

CREATE TABLE "Organization" (
	"orgId" VARCHAR(191) NOT NULL,
	"organizationName" VARCHAR(191) NOT NULL,
	"isPublic" BOOLEAN NOT NULL,
	"authenticatedPages" VARCHAR(191) NOT NULL,
	PRIMARY KEY("orgId")
);

CREATE TABLE "OrgImages" (
	"fileName" VARCHAR(191) NOT NULL,
	"image" BYTEA NOT NULL,
	"orgId" VARCHAR(191) NOT NULL,
	FOREIGN KEY("orgId") REFERENCES "Organization"("orgId"),
	PRIMARY KEY("orgId","fileName")
);

CREATE TABLE "ThrottlingPolicy" (
	"policyId" VARCHAR(191) NOT NULL,
	"type" VARCHAR(191) NOT NULL,
	"policyName" VARCHAR(191) NOT NULL,
	"description" VARCHAR(191) NOT NULL,
	"apimetadataApiId" VARCHAR(191) NOT NULL,
	"apimetadataOrgId" VARCHAR(191) NOT NULL,
	FOREIGN KEY("apimetadataApiId", "apimetadataOrgId") REFERENCES "ApiMetadata"("apiId", "orgId"),
	PRIMARY KEY("policyId")
);

CREATE TABLE "ApiContent" (
	"apiContent" TEXT NOT NULL,
	"apiId" VARCHAR(191) NOT NULL,
	"orgId" VARCHAR(191) NOT NULL,
	FOREIGN KEY("apiId", "orgId") REFERENCES "ApiMetadata"("apiId", "orgId"),
	PRIMARY KEY("apiId","orgId")
);

CREATE TABLE "AdditionalProperties" (
	"key" VARCHAR(191) NOT NULL,
	"value" VARCHAR(191) NOT NULL,
	"apiId" VARCHAR(191) NOT NULL,
	"orgId" VARCHAR(191) NOT NULL,
	FOREIGN KEY("apiId", "orgId") REFERENCES "ApiMetadata"("apiId", "orgId"),
	PRIMARY KEY("apiId","orgId","key")
	
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
	"apiOrgId" VARCHAR(191) NOT NULL,
	FOREIGN KEY("apiApiId", "apiOrgId") REFERENCES "ApiMetadata"("apiId", "orgId"),
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
	"apifeedbackOrgId" VARCHAR(191) NOT NULL,
	FOREIGN KEY("apifeedbackApiId", "apifeedbackOrgId") REFERENCES "ApiMetadata"("apiId", "orgId"),
	"reviewedbyUserId" VARCHAR(191) NOT NULL,
	FOREIGN KEY("reviewedbyUserId") REFERENCES "User"("userId"),
	PRIMARY KEY("reviewId")
);

CREATE TABLE "ApiImages" (
	"imageTag" VARCHAR(191) NOT NULL,
	"imagePath" VARCHAR(191) NOT NULL,
	"image" BYTEA NOT NULL,
	"apiId" VARCHAR(191) NOT NULL,
	"orgId" VARCHAR(191) NOT NULL,
	FOREIGN KEY("apiId", "orgId") REFERENCES "ApiMetadata"("apiId", "orgId"),
	PRIMARY KEY("imageTag","apiId","orgId")
);

CREATE TABLE "OrganizationAssets" (
	"pageType" VARCHAR(191) NOT NULL,
	"pageContent" TEXT NOT NULL,
	"orgName" VARCHAR(191) NOT NULL,
	"organizationOrgId" VARCHAR(191) NOT NULL,
	FOREIGN KEY("organizationOrgId") REFERENCES "Organization"("orgId"),
	PRIMARY KEY("pageType","orgName")
);
