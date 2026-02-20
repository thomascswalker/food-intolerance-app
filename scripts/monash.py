# bread=21a84b4c-a18a-49ae-9479-3e367fccc310
# veggie=c751989b-5e78-4112-85af-b742c50c54dc
# fruit=ddb3ff45-ff5d-4e6b-876d-2485933b05d1
# dairy=522da53a-8d2b-458f-bc25-716b1b2d611f
# tofunuts=69385cf2-02ab-4164-a978-779abdf3285c
# confections=0d123a4e-0161-4c4c-9a58-6966e6cc4230
# snacks=56ceee57-003a-42e3-afb6-0fc9a75ea798
# condiments=68c51bdb-c722-4935-a352-2150b87600de
# beverages=5d93ad37-f09e-4cb1-b932-01b586e32364
#
# https://www.monashfodmap.net/apin/v1/en/US/food-list/{guid}/pageno/0/itemsperpage/20

from enum import IntEnum, auto
import json
import httpx

categories = {
    "bread": "21a84b4c-a18a-49ae-9479-3e367fccc310",
    "veggie": "c751989b-5e78-4112-85af-b742c50c54dc",
    "fruit": "ddb3ff45-ff5d-4e6b-876d-2485933b05d1",
    "dairy": "522da53a-8d2b-458f-bc25-716b1b2d611f",
    "tofunuts": "69385cf2-02ab-4164-a978-779abdf3285c",
    "confections": "0d123a4e-0161-4c4c-9a58-6966e6cc4230",
    "snacks": "56ceee57-003a-42e3-afb6-0fc9a75ea798",
    "condiments": "68c51bdb-c722-4935-a352-2150b87600de",
    "beverages": "5d93ad37-f09e-4cb1-b932-01b586e32364",
}


class Fodmap(IntEnum):
    FRUCTOSE = auto()
    LACTOSE = auto()
    SORBITOL = auto()
    MANNITOL = auto()
    FRUCTAN = auto()
    GOS = auto()


all_food = []

for category, guid in categories.items():
    url = f"https://www.monashfodmap.net/apin/v1/en/US/food-list/{guid}/pageno/0/itemsperpage/200"

    response = httpx.get(url)
    data = response.json()
    data["category"] = category
    all_food.extend(data["food"])

print(len(all_food))

with open("monash_food.json", "w") as f:
    json.dump({"foods": all_food}, f, indent=2)
