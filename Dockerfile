FROM python:3.9 
# Or any preferred Python version.
ADD main.py .
#RUN pip install requests beautifulsoup4 python-dotenv
RUN pip install --no-cache-dir -r requirements.txt
# Make port 80 available to the world outside this container
EXPOSE 80
CMD [“python”, “./exporter.py”] 