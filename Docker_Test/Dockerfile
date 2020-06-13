FROM alpine:latest

RUN apk add --no-cache py-pip python3-dev jpeg-dev zlib-dev libffi-dev openssl-dev gcc libc-dev make \ 
	&& pip3 install --upgrade pip

WORKDIR /app

COPY . /app

RUN pip3 --no-cache-dir install -r requirements.txt

EXPOSE 5000

ENTRYPOINT ["python3"]
CMD ["run.py"]
