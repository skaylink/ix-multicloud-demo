package test

import (
	"crypto/tls"
	"testing"
	"time"
	http_helper "github.com/gruntwork-io/terratest/modules/http-helper"
	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestAllInAzureCluster(t *testing.T) {
	t.Parallel()
	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../terraform",
		Vars: map[string]interface{}{
			"klaus_provider": "azure",
			"petra_provider": "azure",
		},
	})
	defer terraform.Destroy(t, terraformOptions)
	terraform.InitAndApply(t, terraformOptions)
	
	// Network config
	tlsConfig := tls.Config{}
	maxRetries := 30
	timeBetweenRetries := 5 * time.Second
        
	// Start test
	AzureIngressURL := terraform.Output(t, terraformOptions, "azure_ingress_url")
	http_helper.HttpGetWithRetryWithCustomValidation(
		t,
		AzureIngressURL,
		&tlsConfig,
		maxRetries,
		timeBetweenRetries,
		func(statusCode int, body string) bool {
			return statusCode == 403
		},
	)
}

func TestAllInAzureSystem(t *testing.T) {
	t.Parallel()
	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../terraform",
		Vars: map[string]interface{}{
			"klaus_provider": "azure",
			"petra_provider": "azure",
		},
	})
	defer terraform.Destroy(t, terraformOptions)
	terraform.InitAndApply(t, terraformOptions)
	
	// Network config
	tlsConfig := tls.Config{}
	maxRetries := 30
	timeBetweenRetries := 5 * time.Second

	// Start test
	KlausIngressURL := terraform.Output(t, terraformOptions, "klaus_url")
	http_helper.HttpGetWithRetry(
		t, 
		KlausIngressURL, 
		&tlsConfig, 
		200, 
		"Hello world", 
		maxRetries, 
		timeBetweenRetries,
	)
}