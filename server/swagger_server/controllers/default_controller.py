from random import *
import string
import database

import connexion
from swagger_server.models.coupon import Coupon
from swagger_server.models.error import Error
from swagger_server.models.product import Product
from datetime import date, datetime
from typing import List, Dict
from six import iteritems


# from .util import deserialize_date, deserialize_datetime


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
    global ite
    items = database.getCart(userId)
    if items is None:
        return Error(400, "Nothing in cart", "Add something to your cart to be able to get a coupon")
    if len(items) == 0:
        return Error(400, "Nothing in cart", "Add something to your cart to be able to get a coupon")
    item = items[randint(0, len(items) - 1)]
    amount = randint(1, 9).__str__()
    name = database.getProductFromCollection(item)
    coupon_code = amount + "_" + item
    return Coupon("Save $0." + amount + "0 on " + name,
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
