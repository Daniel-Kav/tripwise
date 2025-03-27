from django.contrib.auth.models import AbstractUser
from django.db import models
from django.utils.translation import gettext_lazy as _

class User(AbstractUser):
    class Role(models.TextChoices):
        DRIVER = 'DRIVER', _('Driver')
        ADMIN = 'ADMIN', _('Administrator')
        DISPATCHER = 'DISPATCHER', _('Dispatcher')

    role = models.CharField(
        max_length=20,
        choices=Role.choices,
        default=Role.DRIVER
    )
    phone_number = models.CharField(max_length=15, blank=True)
    company_name = models.CharField(max_length=100, blank=True)
    driver_license_number = models.CharField(max_length=50, blank=True)
    driver_license_state = models.CharField(max_length=2, blank=True)
    is_active = models.BooleanField(default=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        verbose_name = _('User')
        verbose_name_plural = _('Users')
        ordering = ['-created_at']

    def __str__(self):
        return f"{self.username} ({self.get_role_display()})"

class Company(models.Model):
    name = models.CharField(max_length=100)
    mc_number = models.CharField(max_length=20, blank=True)
    dot_number = models.CharField(max_length=20, blank=True)
    address = models.TextField()
    phone = models.CharField(max_length=15)
    email = models.EmailField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        verbose_name_plural = 'Companies'
        ordering = ['name']

    def __str__(self):
        return self.name

class Vehicle(models.Model):
    class Status(models.TextChoices):
        ACTIVE = 'ACTIVE', _('Active')
        MAINTENANCE = 'MAINTENANCE', _('Maintenance')
        INACTIVE = 'INACTIVE', _('Inactive')

    company = models.ForeignKey(Company, on_delete=models.CASCADE, related_name='vehicles')
    unit_number = models.CharField(max_length=20, unique=True)
    vin = models.CharField(max_length=17, unique=True)
    make = models.CharField(max_length=50)
    model = models.CharField(max_length=50)
    year = models.IntegerField()
    status = models.CharField(
        max_length=20,
        choices=Status.choices,
        default=Status.ACTIVE
    )
    eld_device_id = models.CharField(max_length=50, blank=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        ordering = ['unit_number']

    def __str__(self):
        return f"{self.unit_number} - {self.make} {self.model} ({self.year})"

class DriverProfile(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE, related_name='driver_profile')
    company = models.ForeignKey(Company, on_delete=models.CASCADE, related_name='drivers')
    vehicle = models.ForeignKey(Vehicle, on_delete=models.SET_NULL, null=True, blank=True, related_name='assigned_drivers')
    current_cycle = models.IntegerField(default=0)  # Current hours in the 70-hour cycle
    cycle_start_date = models.DateTimeField()
    last_break_start = models.DateTimeField(null=True, blank=True)
    last_break_duration = models.DurationField(null=True, blank=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        ordering = ['-created_at']

    def __str__(self):
        return f"{self.user.get_full_name()} - {self.company.name}" 