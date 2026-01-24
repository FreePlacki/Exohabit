import requests
import csv

N = 100

url = f"https://exoplanetarchive.ipac.caltech.edu/TAP/sync?request=doQuery&lang=ADQL&format=json&query=SELECT%20TOP%20{N}%20pl_name,hostname,disc_year,discoverymethod,pl_orbper,pl_rade,pl_masse,pl_eqt,st_spectype,sy_dist%20FROM%20ps%20WHERE%20default_flag=1%20ORDER%20BY%20(CASE%20WHEN%20pl_orbper%20IS%20NULL%20THEN%201%20ELSE%200%20END)%20%2B%20(CASE%20WHEN%20pl_rade%20IS%20NULL%20THEN%205%20ELSE%200%20END)%20%2B%20(CASE%20WHEN%20pl_masse%20IS%20NULL%20THEN%202%20ELSE%200%20END)%20%2B%20(CASE%20WHEN%20pl_eqt%20IS%20NULL%20THEN%205%20ELSE%200%20END)%20%2B%20(CASE%20WHEN%20st_spectype%20IS%20NULL%20THEN%201%20ELSE%200%20END)%20%2B%20(CASE%20WHEN%20sy_dist%20IS%20NULL%20THEN%201%20ELSE%200%20END),disc_year%20DESC"

response = requests.get(url)
response.raise_for_status()
data = response.json()  # Returns a dict with keys 'fields' and 'data'

print(data)
fields = list(data[0].keys())  # Only if data is a list of dicts
rows = [[d.get(f) for f in fields] for d in data]

# 2️⃣ Write to CSV
with open("exoplanets.csv", "w", newline="", encoding="utf-8") as csvfile:
    writer = csv.writer(csvfile)
    writer.writerow(fields)
    for row in rows:
        writer.writerow(row)

print("CSV saved as exoplanets.csv")
