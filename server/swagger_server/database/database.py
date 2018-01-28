carts = {}
products = {}


def addProductToCollection(sku, productName):
    if sku not in products.keys():
        products[sku] = productName
        print("Added " + productName + " to the db")


def getProductFromCollection(sku):
    if sku in products.keys():
        return products.get(sku)


def addProductToCart(customerId, sku):
    if customerId in carts.keys():
        carts[customerId].append(sku)
        print("Added " + sku + " to " + customerId + "'s cart")
    else:
        carts[customerId] = [sku]
        print("Added " + sku + " to " + customerId + "'s cart")


def removeProductFromCart(customerId, sku):
    if customerId in carts.keys():
        try:
            carts[customerId].remove(sku)
            print("Removed " + sku + " to " + customerId + " cart")
            return True
        except ValueError:
            return False
    return False


def getCart(customerId):
    if customerId in carts.keys():
        return carts.get(customerId)


def printProducts():
    for k, v in carts.items():
        print(k, v)
