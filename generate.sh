#!/bin/bash

mkdir -p fabbrike/{docs,projects/{project1/{src,tests,docs},project2/{src,tests,docs}},tools/{scripts,config},.github/{workflows,ISSUE_TEMPLATE}}

touch fabbrike/docs/{architecture.md,guidelines.md,setup.md}
touch fabbrike/projects/project1/README.md
touch fabbrike/projects/project2/README.md
touch fabbrike/tools/README.md
touch fabbrike/.github/ISSUE_TEMPLATE/bug_report.md
touch fabbrike/.github/workflows/deploy.yml

