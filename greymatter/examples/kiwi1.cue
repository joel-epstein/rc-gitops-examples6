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
	description:   "EDIT ME"
	api_endpoint:              "http://\(context.globals.edge_host)/services/\(context.globals.namespace)/\(name)/"
	api_spec_endpoint:         "http://\(context.globals.edge_host)/services/\(context.globals.namespace)/\(name)/"
	
	business_impact:           "low"
	owner: "Examples"
	capability: ""
	
	// Kiwi1 -> ingress to your container
	ingress: {
		(name): {
			gsl.#HTTPListener
			
			
			
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
				
			}
		}
	}
	
}

exports: "kiwi1": Kiwi1
