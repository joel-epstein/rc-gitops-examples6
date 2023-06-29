package globals

import (
	gsl "greymatter.io/gsl/v1"
)

globals: gsl.#DefaultContext & {
	edge_host: "20.231.237.156:10809"
	namespace: "examples"
	
	// Please contact your mesh administrators as to what
	// values must be set per your mesh deployment.
	mesh: {
		name: string
	}
}
