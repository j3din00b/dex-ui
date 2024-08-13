FROM node:16

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

RUN apt-get update && apt-get install -y \
    python3-pip \
    git \
    golang-go \
    && apt-get clean

RUN pip3 install -r tools/hackbot/requirements.txt
RUN pip3 install -r tools/dorkscanner/requirements.txt

RUN go install -v github.com/projectdiscovery/naabu/v2/cmd/naabu@latest

EXPOSE 8080

CMD ["npm", "start"]
