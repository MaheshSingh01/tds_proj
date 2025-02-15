# Use Python 3.12 slim Bookworm base image
FROM python:3.12-slim-bookworm



# Set the working directory
WORKDIR /app

# Install dependencies
RUN apt-get update && \
    apt-get install -y python3-pip && \
    pip install --no-cache-dir --upgrade pip

# Copy the application code
COPY . .

# Install Node.js and Prettier
RUN apt update && apt install -y nodejs npm
RUN npm install -g prettier

RUN mkdir -p /data


COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Install required Python packages
RUN pip install --no-cache-dir fastapi uvicorn pandas numpy faker matplotlib seaborn scikit-learn

# Expose the port the app runs on
EXPOSE 8000

# Command to run the application
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]
