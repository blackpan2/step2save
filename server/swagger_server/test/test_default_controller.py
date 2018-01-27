# coding: utf-8

from __future__ import absolute_import

from swagger_server.models.coupon import Coupon
from swagger_server.models.error import Error
from swagger_server.models.search_results import SearchResults
from swagger_server.models.street_address import StreetAddress
from . import BaseTestCase
from six import BytesIO
from flask import json


class TestDefaultController(BaseTestCase):
    """ DefaultController integration test stubs """

    def test_add_get(self):
        """
        Test case for add_get

        Adds an item to a user's shopping cart
        """
        query_string = [('userId', 'userId_example'),
                        ('SKU', 'SKU_example')]
        response = self.client.open('/v1/add',
                                    method='GET',
                                    query_string=query_string)
        self.assert200(response, "Response body is : " + response.data.decode('utf-8'))

    def test_arrival_get(self):
        """
        Test case for arrival_get

        Check if device is located at a Wegman's store.
        """
        query_string = [('latitude', 1.2),
                        ('longitude', 1.2)]
        response = self.client.open('/v1/arrival',
                                    method='GET',
                                    query_string=query_string)
        self.assert200(response, "Response body is : " + response.data.decode('utf-8'))

    def test_coupon_get(self):
        """
        Test case for coupon_get

        Get a coupon for a customer
        """
        query_string = [('userId', 'userId_example')]
        response = self.client.open('/v1/coupon',
                                    method='GET',
                                    query_string=query_string)
        self.assert200(response, "Response body is : " + response.data.decode('utf-8'))

    def test_nearest_get(self):
        """
        Test case for nearest_get

        Find the nearest Wegman's Location
        """
        query_string = [('latitude', 1.2),
                        ('longitude', 1.2)]
        response = self.client.open('/v1/nearest',
                                    method='GET',
                                    query_string=query_string)
        self.assert200(response, "Response body is : " + response.data.decode('utf-8'))

    def test_remove_get(self):
        """
        Test case for remove_get

        Remove Item from a user's shopping cart
        """
        query_string = [('userId', 'userId_example'),
                        ('SKU', 'SKU_example')]
        response = self.client.open('/v1/remove',
                                    method='GET',
                                    query_string=query_string)
        self.assert200(response, "Response body is : " + response.data.decode('utf-8'))

    def test_search_get(self):
        """
        Test case for search_get

        Pass through for the Wegman's \"Products_SearchProducts\" endpoint
        """
        query_string = [('criteria', 'criteria_example')]
        response = self.client.open('/v1/search',
                                    method='GET',
                                    query_string=query_string)
        self.assert200(response, "Response body is : " + response.data.decode('utf-8'))


if __name__ == '__main__':
    import unittest
    unittest.main()
