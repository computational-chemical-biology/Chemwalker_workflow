

run:
	nextflow run ./nf_workflow.nf  --taskid $(taskid) --workflow $(workflow) --comp $(comp) --db $(db) -resume -c nextflow.config

clean:
	rm -Rf .nextflow* work bin/*__pycache__* nf_output/*

run_hpcc:
	nextflow run ./nf_workflow.nf -resume -c nextflow_hpcc.config

run_docker:
	nextflow run ./nf_workflow.nf -resume -with-docker <CONTAINER NAME>
