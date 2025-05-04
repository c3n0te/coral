# Build Podman Based Coral TPU Dev Environment
`podman build -f Containerfile --rm -t coral:v0.1 --no-cache`

# Run Podman Coral TPU Dev Environment w/ Shell Access
`podman run -it --group-add keep-groups -v /dev:/dev --name coral localhost/coral:v0.1`

# To Verify Models Can Be Run on TPU
`mkdir /home/coral && cd /home/coral && git clone https://github.com/google-coral/pycoral.git`
<br>
`cd /home/coral/pycoral && bash examples/install_requirements.sh classify_image.py`
<br>
`python3 examples/classify_image.py \
--model test_data/mobilenet_v2_1.0_224_inat_bird_quant_edgetpu.tflite \
--labels test_data/inat_bird_labels.txt \
--input test_data/parrot.jpg`


Note this run command inherits the current user's permissions to all devices in the
/dev directory on the host and provides access to all devices the container. This is 
fine for dev environments with my specific configuration for what I need. Review these
assumptions. YMMV.

This repo was directly inspired by ![fvalle1/coral-docker-mnist](https://github.com/fvalle1/coral-docker-mnist) 
on GitHub. I was having trouble installing the correct versions of the system libraries
needed to compile and install the Coral TPU software and pulled the above repo to 
play around.

However, I made a few changes:
1. Podman instead of Docker, b/c rootless containers (not silver bullet but something I 
   value and think is important).
2. Update to Debian Bullseye & Python3.9 -- Buster and Python3.7 are EOL
3. Use the example from the ![Google Coral TPU documentation](https://coral.ai/docs/accelerator/get-started/#3-run-a-model-on-the-edge-tpu)
