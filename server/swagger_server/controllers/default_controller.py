import connexion
from swagger_server.models.coupon import Coupon
from swagger_server.models.error import Error
from swagger_server.models.search_results import SearchResults
from swagger_server.models.street_address import StreetAddress
from datetime import date, datetime
from typing import List, Dict
from six import iteritems
from ..util import deserialize_date, deserialize_datetime


def add_get(userId, SKU):
    """
    Adds an item to a user&#39;s shopping cart
    
    :param userId: Customer userId
    :type userId: str
    :param SKU: SKU of product to be added
    :type SKU: str

    :rtype: None
    """
    return 'do some magic!'


def arrival_get(latitude, longitude):
    """
    Check if device is located at a Wegman&#39;s store.
    
    :param latitude: Latitude component of location.
    :type latitude: float
    :param longitude: Longitude component of location.
    :type longitude: float

    :rtype: bool
    """
    return 'do some magic!'


def coupon_get(userId):
    """
    Get a coupon for a customer
    
    :param userId: Customer userId
    :type userId: str

    :rtype: Coupon
    """
    return 'do some magic!'


def nearest_get(latitude, longitude):
    """
    Find the nearest Wegman&#39;s Location
    
    :param latitude: Latitude component of location.
    :type latitude: float
    :param longitude: Longitude component of location.
    :type longitude: float

    :rtype: StreetAddress
    """
    return 'do some magic!'


def remove_get(userId, SKU):
    """
    Remove Item from a user&#39;s shopping cart
    
    :param userId: Customer UID
    :type userId: str
    :param SKU: SKU of product to be removed
    :type SKU: str

    :rtype: None
    """
    return 'do some magic!'


def search_get(criteria):
    """
    Pass through for the Wegman&#39;s \&quot;Products_SearchProducts\&quot; endpoint
    
    :param criteria: The search criteria.
    :type criteria: str

    :rtype: SearchResults
    """
    return 'do some magic!'
