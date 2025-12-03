# Use Ubuntu as base image
FROM quay.io/crowdstrike/vulnapp
# Not picked up as a secret 
ENV AWS_ACCESS_KEY_ID=AKIAIOSFODNN7EXAMPLE
ENV AWS_SECRET_ACCESS_KEY=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
