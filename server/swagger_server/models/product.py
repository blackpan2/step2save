# coding: utf-8

from __future__ import absolute_import
from .base_model_ import Model
from datetime import date, datetime
from typing import List, Dict
from ..util import deserialize_model


class Product(Model):
    """
    NOTE: This class is auto generated by the swagger code generator program.
    Do not edit the class manually.
    """
    def __init__(self, name: str=None, sku: str=None):
        """
        Product - a model defined in Swagger

        :param name: The name of this Product.
        :type name: str
        :param sku: The sku of this Product.
        :type sku: str
        """
        self.swagger_types = {
            'name': str,
            'sku': str
        }

        self.attribute_map = {
            'name': 'name',
            'sku': 'sku'
        }

        self._name = name
        self._sku = sku

    @classmethod
    def from_dict(cls, dikt) -> 'Product':
        """
        Returns the dict as a model

        :param dikt: A dict.
        :type: dict
        :return: The Product of this Product.
        :rtype: Product
        """
        return deserialize_model(dikt, cls)

    @property
    def name(self) -> str:
        """
        Gets the name of this Product.

        :return: The name of this Product.
        :rtype: str
        """
        return self._name

    @name.setter
    def name(self, name: str):
        """
        Sets the name of this Product.

        :param name: The name of this Product.
        :type name: str
        """

        self._name = name

    @property
    def sku(self) -> str:
        """
        Gets the sku of this Product.

        :return: The sku of this Product.
        :rtype: str
        """
        return self._sku

    @sku.setter
    def sku(self, sku: str):
        """
        Sets the sku of this Product.

        :param sku: The sku of this Product.
        :type sku: str
        """

        self._sku = sku

