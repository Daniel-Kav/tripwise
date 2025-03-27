from django.db import models
from django.conf import settings
from django.utils.translation import gettext_lazy as _
from core.models import Vehicle, DriverProfile

class Trip(models.Model):
    class Status(models.TextChoices):
        PLANNED = 'PLANNED', _('Planned')
        IN_PROGRESS = 'IN_PROGRESS', _('In Progress')
        COMPLETED = 'COMPLETED', _('Completed')
        CANCELLED = 'CANCELLED', _('Cancelled')

    driver = models.ForeignKey(DriverProfile, on_delete=models.CASCADE, related_name='trips')
    vehicle = models.ForeignKey(Vehicle, on_delete=models.CASCADE, related_name='trips')
    status = models.CharField(
        max_length=20,
        choices=Status.choices,
        default=Status.PLANNED
    )
    start_location = models.CharField(max_length=200)
    end_location = models.CharField(max_length=200)
    start_time = models.DateTimeField()
    estimated_end_time = models.DateTimeField()
    actual_end_time = models.DateTimeField(null=True, blank=True)
    total_distance = models.DecimalField(max_digits=10, decimal_places=2, null=True, blank=True)
    notes = models.TextField(blank=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        ordering = ['-created_at']

    def __str__(self):
        return f"Trip {self.id}: {self.start_location} to {self.end_location}"

class Stop(models.Model):
    class StopType(models.TextChoices):
        PICKUP = 'PICKUP', _('Pickup')
        DROPOFF = 'DROPOFF', _('Drop-off')
        FUEL = 'FUEL', _('Fuel Stop')
        REST = 'REST', _('Rest Break')
        MAINTENANCE = 'MAINTENANCE', _('Maintenance')

    trip = models.ForeignKey(Trip, on_delete=models.CASCADE, related_name='stops')
    stop_type = models.CharField(
        max_length=20,
        choices=StopType.choices
    )
    location = models.CharField(max_length=200)
    latitude = models.DecimalField(max_digits=9, decimal_places=6)
    longitude = models.DecimalField(max_digits=9, decimal_places=6)
    planned_arrival = models.DateTimeField()
    actual_arrival = models.DateTimeField(null=True, blank=True)
    planned_departure = models.DateTimeField()
    actual_departure = models.DateTimeField(null=True, blank=True)
    duration = models.DurationField(null=True, blank=True)
    notes = models.TextField(blank=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        ordering = ['planned_arrival']

    def __str__(self):
        return f"{self.get_stop_type_display()} at {self.location}"

class Route(models.Model):
    trip = models.OneToOneField(Trip, on_delete=models.CASCADE, related_name='route')
    route_data = models.JSONField()  # Stores the complete route data including waypoints
    total_distance = models.DecimalField(max_digits=10, decimal_places=2)
    estimated_duration = models.DurationField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return f"Route for Trip {self.trip.id}"

class RestArea(models.Model):
    name = models.CharField(max_length=200)
    location = models.CharField(max_length=200)
    latitude = models.DecimalField(max_digits=9, decimal_places=6)
    longitude = models.DecimalField(max_digits=9, decimal_places=6)
    amenities = models.JSONField(default=dict)  # Stores available amenities
    is_active = models.BooleanField(default=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        ordering = ['name']

    def __str__(self):
        return self.name

class FuelStation(models.Model):
    name = models.CharField(max_length=200)
    location = models.CharField(max_length=200)
    latitude = models.DecimalField(max_digits=9, decimal_places=6)
    longitude = models.DecimalField(max_digits=9, decimal_places=6)
    brand = models.CharField(max_digits=100, blank=True)
    amenities = models.JSONField(default=dict)  # Stores available amenities
    is_active = models.BooleanField(default=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        ordering = ['name']

    def __str__(self):
        return f"{self.name} ({self.brand})" 