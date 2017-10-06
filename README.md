deep learning platform base, including theano, tensorflow, jupyter notebook.

Usage:
docker run -d --rm -ti -v /path/to/notebooks:/opt/notebooks -p 8888:8888 \
-e NOTEBOOK_PASSWORD=sha1:50ca543fc3e0:d220f2111686b1ace076be0473f7dcbfc82a1fde \
flowerseems/dl-base

Use NOTEBOOK_PASSWORD to change password.
You can generate password hash by using:

docker run --rm flowerseems/dl-base python -c "from IPython.lib import passwd; print(passwd('yourpassword'))"
'sha1:50ca543fc3e0:d220f2111686b1ace076be0473f7dcbfc82a1fde'

The string starts with sha1 is your password environment variable.
