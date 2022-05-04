import fastapi
import uvicorn
import requests
import os

app = fastapi.FastAPI()

@app.get("/")
async def root():
    r = requests.get(os.getenv('PETRA_ADDR') + '/')
    return fastapi.responses.PlainTextResponse(r.content.decode('utf-8') + ' world')
    
if __name__ == "__main__":
    uvicorn.run('main:app', host="0.0.0.0", port=80, reload=True, debug=True)
