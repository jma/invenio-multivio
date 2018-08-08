# -*- coding: utf-8 -*-
# Image.open(path)
# This file is part of Invenio.
# Copyright (C) 2018 RERO.
#
# Invenio is free software; you can redistribute it
# and/or modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation; either version 2 of the
# License, or (at your option) any later version.
#
# Invenio is distributed in the hope that it will be
# useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Invenio; if not, write to the
# Free Software Foundation, Inc., 59 Temple Place, Suite 330, Boston,
# MA 02111-1307, USA.
#
# In applying this license, RERO does not
# waive the privileges and immunities granted to it by virtue of its status
# as an Intergovernmental Organization or submit itself to any jurisdiction.

"""Generic browser and visualizer for digital objects."""

import json
import os

import pytest


@pytest.yield_fixture()
def simple_json():
    """Get path for tests."""
    path = os.path.join(os.path.dirname(__file__), '../data/doppler.json')
    yield path


@pytest.yield_fixture()
def simple_json_no_records():
    """Get path for tests."""
    path = os.path.join(os.path.dirname(__file__),
                        '../data/doppler_no_records.json')
    yield path


@pytest.yield_fixture()
def simple_json_no_label():
    """Get path for tests."""
    path = os.path.join(os.path.dirname(__file__),
                        '../data/doppler_physical_error.json')
    yield path
