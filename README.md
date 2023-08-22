# Nextflow Template

To test the workflow the next command should be executed:

```
make run [-e --taskid $taskid --workflow $workflow --comp $comp --db $db --metfragpath $metfragpath
```

For documentation about the MS2LDA tool, please read the source tool [publication](https://doi.org/10.1093/bioinformatics/btad078) and [repository](https://github.com/computational-chemical-biology/ChemWalker/)

The variables taskid, and comp are mandatory and do not have default values. 
However, workflow, db and metfragpath have default values. The workflow will be FBMN if not specified V2, db will be COCONUT, and metfragpath will be the commandline present in the github for the version 2.3. 
```

To learn NextFlow checkout this documentation:

https://www.nextflow.io/docs/latest/index.html

## Installation

You will need to have conda, mamba, and nextflow installed to run things locally. 

## Deployment to GNPS2

In order to deploy, we have a set of deployment tools that will enable deployment to the various gnps2 systems. To run the deployment, you will need the following setup steps completed:

1. Checked out of the deployment submodules
1. Conda environment and dependencies
1. SSH configuration updated

### Checking out the deployment submodules

use the following commands from the deploy_gnps2 folder. 

You might need to checkout the module, do this by running

```
git submodule init
git submodule update
```

You will also need to specify the user on the server that you've been given that your public key has been associated with. If you want to not enter this every time you do a deployment, you can create a Makefile.credentials file in the deploy_gnps2 folder with the following contents

```
USERNAME=<enter the username>
```

### Deployment Dependencies

You will need to install the dependencies in GNPS2_DeploymentTooling/requirements.txt on your own local machine. 

One way to do this is to use conda to create an environment, for example:

```
conda create -n deploy python=3.8
pip install -r GNPS2_DeploymentTooling/requirements.txt
```

### SSH Configuration

Also update your ssh config file to include the following ssh target:

```
Host ucr-gnps2-dev
    Hostname ucr-lemon.duckdns.org
```

### Deploying to Dev Server

To deploy to development, use the following command, if you don't have your ssh public key installed onto the server, you will not be able to deploy.

```
make deploy-dev
```

### Deploying to Production Server

To deploy to production, use the following command, if you don't have your ssh public key installed onto the server, you will not be able to deploy.

```
make deploy-prod
```