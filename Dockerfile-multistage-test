# Stage 1: Build stage with a fatter image that includes build tools
FROM python:3.8-buster as build

# Set the working directory
WORKDIR /app

# Add the current directory contents into the container at /app
ADD . /app

# Install the Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Stage 2: Final, slimmer image using Alpine
FROM python:3.8-alpine

# Set the working directory
WORKDIR /app

# Copy only the installed packages from the build stage
COPY --from=build /usr/local/lib/python3.8/site-packages /usr/local/lib/python3.8/site-packages
COPY --from=build /usr/local/bin /usr/local/bin

# Copy the application files
COPY . /app

# Install runtime dependencies (if any)
RUN apk add --no-cache libffi

# Make port 80 available to the world outside this container
EXPOSE 80

# Run exporter.py when the container launches
CMD ["python3", "exporter.py"]