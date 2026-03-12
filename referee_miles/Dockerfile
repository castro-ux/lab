FROM quay.io/jupyter/base-notebook

#Switch to root to mount volume with specific owner permissions. 
USER root

#Install vim and clean up cache 
RUN apt-get update && \
    apt-get install -y vim && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

#Create import dir and fix ownership 
RUN mkdir -p /home/jovyan/app/imports && \
    chown -R 1000:100 /home/jovyan/app

#Drop root privilages and set working dir
USER jovyan
WORKDIR /home/jovyan/app

#Install Python libraries
COPY --chown=1000:100 requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

#Copy files in my current folder into container working directory 
COPY --chown=1000:100 . .

#Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 CMD curl -f http://localhost:8889/ || exit 1
