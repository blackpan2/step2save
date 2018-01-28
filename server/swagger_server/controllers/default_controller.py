import random
import string
import database

import connexion
from swagger_server.models.coupon import Coupon
from swagger_server.models.error import Error
from swagger_server.models.product import Product
from datetime import date, datetime
from typing import List, Dict
from six import iteritems
from ..util import deserialize_date, deserialize_datetime


def add_get(userId, productName, sku):
    """
    Adds an item to a user&#39;s shopping cart

    :param userId: Customer userId
    :type userId: str
    :param productName: The name of the product
    :type productName: str
    :param sku: SKU of product to be added
    :type sku: str

    :rtype: Product
    """
    database.addProductToCollection(sku, productName)
    database.addProductToCart(userId, sku)
    return Product(productName, sku)


def coupon_get(userId):
    """
    Get a coupon for a customer

    :param userId: Customer userId
    :type userId: str

    :rtype: Coupon
    """
    items = database.getCart(userId)
    if len(items) == 0:
        return Error(400, "Nothing in cart", "Add something to your cart to be able to get a coupon")
    item = items[random.randint(0, len(items) - 1)]
    coupon_code = ''.join(random.choices(string.ascii_uppercase + string.digits, k=10))
    return Coupon("Save $" + random.randint(1, 11).__str__() + ".00 on " + database.getProductFromCollection(item),
                  coupon_code)


def remove_get(userId, productName, sku):
    """
    Remove Item from a user&#39;s shopping cart

    :param userId: Customer userId
    :type userId: str
    :param productName: The name of the product
    :type productName: str
    :param sku: SKU of product to be removed
    :type sku: str

    :rtype: Product
    """
    database.removeProductFromCart(userId, sku)
    return Product(productName, sku)
