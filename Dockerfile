FROM balenalib/raspberry-pi-alpine-python
# Or any preferred Python version.
ADD exporter.py .
ADD requirements.txt .
#RUN pip install requests beautifulsoup4 python-dotenv
RUN pip install --no-cache-dir -r requirements.txt
# Make port 80 available to the world outside this container
EXPOSE 80
CMD [“python”, “./exporter.py”] 