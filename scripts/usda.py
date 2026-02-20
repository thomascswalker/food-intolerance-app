import json
from enum import IntEnum
import os
import httpx

URL = "https://api.nal.usda.gov/fdc"
API_KEY = "xfcbdVgM1lt4MbZxLsHhb78UppWp9BXmGKrk3dfO"


class Nutrient(IntEnum):
    SUCROSE = 210
    FRUCTOSE = 212
    LACTOSE = 213


def get_foods(page: int):
    url = f"{URL}/v1/foods/list"
    params = {
        "api_key": API_KEY,
        "pageSize": 200,
        "pageNumber": page,
    }
    response = httpx.get(url, params=params)
    return response.json()


capture_nutrients = ["sucrose", "fructose", "lactose"]

if __name__ == "__main__":
    all_foods = []
    os.makedirs("usda_data", exist_ok=True)
    for page in range(1, 70):
        foods_sucrose = []
        foods = get_foods(page)
        for food in foods:
            nutrients = food.get("foodNutrients", [])
            fmt_data = {
                "fdcId": food["fdcId"],
                "description": food["description"],
                "nutrients": [],
            }
            for nutrient in nutrients:
                name = nutrient["name"].lower()
                if name not in capture_nutrients:
                    continue
                fmt_data["nutrients"].append(
                    {
                        "name": name,
                        "amount": nutrient["amount"],
                        "unitName": nutrient["unitName"],
                    }
                )
            if len(fmt_data["nutrients"]) > 0:
                foods_sucrose.append((fmt_data))

        if len(foods_sucrose) == 0:
            continue

        all_foods.extend(foods_sucrose)

    with open("usda_data/usda_sucrose_foods.json", "w") as f:
        json.dump({"foods": all_foods}, f, indent=2)
