package examples

import (
	gsl "greymatter.io/gsl/v1"

	"examples.module/greymatter:globals"
)


Kiwi1: gsl.#Service & {
	// A context provides global information from globals.cue
	// to your service definitions.
	context: Kiwi1.#NewContext & globals

	// name must follow the pattern namespace/name
	name:          "kiwi1"
	display_name:  "Examples Kiwi1"
	version:       "v1.0.0"
	description:   "This is the description field1234"
	api_endpoint:              "https://\(context.globals.edge_host)/services/\(context.globals.namespace)/\(name)/"
	api_spec_endpoint:         "https://\(context.globals.edge_host)/services/\(context.globals.namespace)/\(name)/"
	
	business_impact:           "low"
	owner: "FOOBAR"
	capability: ""
	health_options: {
		tls: gsl.#MTLSUpstream
	}
	// raw_upstreams: {
	// 	"remote-jwks": {
	// 		gsl.#Upstream
	// 		// gsl.#TLSUpstream

	// 		instances: [
	// 			{
	// 				host: "iam2.greymatter.io"
	// 				port: 443
	// 			},
	// 		]

	// 		// ssl_config: {
	// 		// 	protocols: ["TLS_AUTO"]
	// 		// 	cert_key_pairs: [
	// 		// 		{
	// 		// 			certificate_path: "/etc/proxy/tls/iam2/server.crt"
	// 		// 			key_path:         "/etc/proxy/tls/iam2/server.key"
	// 		// 		},
	// 		// 	]

	// 		// }
	// 	}
	// }
	// Kiwi1 -> ingress to your container
	ingress: {
		(name): {
			gsl.#HTTPListener
			gsl.#MTLSListener
			
			//  NOTE: this must be filled out by a user. Impersonation allows other services to act on the behalf of identities
			//  inside the system. Please uncomment if you wish to enable impersonation. If the servers list if left empty,
			//  all traffic will be blocked.
			//	filters: [
			//    gsl.#ImpersonationFilter & {
			//		#options: {
			//			servers: ""
			//			caseSensitive: false
			//		}
			//    }
			//	]
			routes: {
				"/": {
					
					upstreams: {
						"local": {
							gsl.#Upstream
							
							instances: [
								{
									host: "127.0.0.1"
									port: 9090
								},
							]
						}
					}
				}
			}
			// filters: [
			// 	gsl.#OIDCPipelineFilter & {
			// 		#options: {
			// 			provider_host: "https://iam2.greymatter.io"
			// 			clientId:      "greymatter"
			// 			callbackPath:  "/oauth"
			// 			serviceUrl:    "https://staging-01-team-a-wordpress.greymatter.io:10809"
			// 			realm:         "GAT"
			// 			additionalScopes: ["openid"]
			// 			provider_cluster: "remote-jwks"
			// 		}
			// 		#secrets: {
			// 			client_secret: gsl.#KubernetesSecret &{
			// 				namespace: "examples"
			// 				name: "my-secret-1"
			// 				key: "kiwi1"
			// 			}
			// 		}
			// 	},
			// ]
		}
	}


	
	// Edge config for the Kiwi1 service.
	// These configs are REQUIRED for your service to be accessible
	// outside your cluster/mesh.
	edge: {
		edge_name: "edge"
		routes: "/services/\(context.globals.namespace)/\(name)": {
			prefix_rewrite: "/"
			upstreams: (name): {
				gsl.#Upstream
				namespace: context.globals.namespace
				gsl.#MTLSUpstream
			}
		}
	}
	
}

exports: "kiwi1": Kiwi1
