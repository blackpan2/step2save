

products = {}
def addProduct(customerID, productID):
	if customerID in products.keys():
		products[customerID].append(productID)
	else:
		products[customerID] = [productID]


def removeProduct(customerID, productID):
	if customerID in products.keys():
		try:
			products[customerID].remove(productID)
			return True
		except ValueError:
			return False
	return False



def printProducts():
	for k,v in products.items():
		print(k,v)
