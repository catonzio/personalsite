## Script to deploy all the containers (apps) and the main container

import os
from os.path import join as j
# import subprocess as sb

def find_docker_files(s_path):
    files = os.listdir(s_path)
    if "compose.yaml" in files or "docker-compose.yaml" in files:
        return [(s_path, "docker-compose.yaml")]
    elif "deploy.sh" in files:
        return [(s_path, "deploy.sh")]
    elif "Dockerfile" in files:
        return [(s_path, "Dockerfile")]
    else:
        res = []
        for file in files:
            nfile = j(s_path, file)
            if os.path.isdir(nfile):
                res += find_docker_files(nfile)
        return res

def deploy_container(path, filetype):
    os.chdir(path)
    if filetype == "deploy.sh":
        print(f"{os.getcwd()}: ./deploy.sh build")
        os.system("./deploy.sh build")
        # sb.run(*"./deploy.sh build".split(" "))
    elif ".yaml" in filetype or ".yml" in filetype:
        print(f"{os.getcwd()}: docker-compose up --build")
        os.system("docker-compose up --build")
        # sb.run(*"docker-compose up --build".split(" "))
    elif filetype == "Dockerfile":
        fname = path.split("//")[-1]
        print(f"docker -t {fname}:latest build .")
        print(f"docker run -t {fname}:latest")


curr_dir = os.getcwd()
apps_dir = [j(curr_dir, "apps", f) for f in os.listdir("apps")]

files = []
for path in apps_dir:
    files += find_docker_files(path)

for path, filetype in files:
    deploy_container(path, filetype)

