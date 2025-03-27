from django.db import models
from django.utils.translation import gettext_lazy as _
from core.models import DriverProfile, Vehicle
from trips.models import Trip

class LogEntry(models.Model):
    class Status(models.TextChoices):
        ACTIVE = 'ACTIVE', _('Active')
        CERTIFIED = 'CERTIFIED', _('Certified')
        REJECTED = 'REJECTED', _('Rejected')

    class EventType(models.TextChoices):
        DRIVING = 'DRIVING', _('Driving')
        ON_DUTY = 'ON_DUTY', _('On Duty')
        OFF_DUTY = 'OFF_DUTY', _('Off Duty')
        SLEEPER = 'SLEEPER', _('Sleeper Berth')
        PERSONAL = 'PERSONAL', _('Personal Conveyance')
        YARD_MOVE = 'YARD_MOVE', _('Yard Move')

    driver = models.ForeignKey(DriverProfile, on_delete=models.CASCADE, related_name='log_entries')
    vehicle = models.ForeignKey(Vehicle, on_delete=models.CASCADE, related_name='log_entries')
    trip = models.ForeignKey(Trip, on_delete=models.SET_NULL, null=True, blank=True, related_name='log_entries')
    status = models.CharField(
        max_length=20,
        choices=Status.choices,
        default=Status.ACTIVE
    )
    event_type = models.CharField(
        max_length=20,
        choices=EventType.choices
    )
    start_time = models.DateTimeField()
    end_time = models.DateTimeField()
    location = models.CharField(max_length=200)
    latitude = models.DecimalField(max_digits=9, decimal_places=6)
    longitude = models.DecimalField(max_digits=9, decimal_places=6)
    notes = models.TextField(blank=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        verbose_name_plural = 'Log Entries'
        ordering = ['-start_time']

    def __str__(self):
        return f"{self.driver.user.get_full_name()} - {self.get_event_type_display()} ({self.start_time.date()})"

class HOSViolation(models.Model):
    class ViolationType(models.TextChoices):
        DRIVING_TIME = 'DRIVING_TIME', _('11-Hour Driving Limit')
        ON_DUTY_TIME = 'ON_DUTY_TIME', _('14-Hour On-Duty Limit')
        CYCLE_TIME = 'CYCLE_TIME', _('60/70-Hour Cycle Limit')
        BREAK_TIME = 'BREAK_TIME', _('30-Minute Break Requirement')
        RESTART_TIME = 'RESTART_TIME', _('34-Hour Restart Requirement')

    log_entry = models.ForeignKey(LogEntry, on_delete=models.CASCADE, related_name='violations')
    violation_type = models.CharField(
        max_length=20,
        choices=ViolationType.choices
    )
    violation_time = models.DateTimeField()
    violation_duration = models.DurationField()
    description = models.TextField()
    is_resolved = models.BooleanField(default=False)
    resolution_notes = models.TextField(blank=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        ordering = ['-violation_time']

    def __str__(self):
        return f"{self.get_violation_type_display()} - {self.violation_time.date()}"

class DriverCycle(models.Model):
    driver = models.ForeignKey(DriverProfile, on_delete=models.CASCADE, related_name='cycles')
    cycle_type = models.CharField(max_length=20, choices=[
        ('60_7', '60 Hours / 7 Days'),
        ('70_8', '70 Hours / 8 Days'),
    ])
    start_time = models.DateTimeField()
    end_time = models.DateTimeField()
    total_hours = models.DecimalField(max_digits=5, decimal_places=2)
    is_compliant = models.BooleanField(default=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        ordering = ['-start_time']

    def __str__(self):
        return f"{self.driver.user.get_full_name()} - {self.cycle_type} ({self.start_time.date()})"

class Break(models.Model):
    class BreakType(models.TextChoices):
        LUNCH = 'LUNCH', _('Lunch Break')
        REST = 'REST', _('Rest Break')
        SLEEPER = 'SLEEPER', _('Sleeper Berth')
        PERSONAL = 'PERSONAL', _('Personal Conveyance')

    log_entry = models.ForeignKey(LogEntry, on_delete=models.CASCADE, related_name='breaks')
    break_type = models.CharField(
        max_length=20,
        choices=BreakType.choices
    )
    start_time = models.DateTimeField()
    end_time = models.DateTimeField()
    duration = models.DurationField()
    location = models.CharField(max_length=200)
    latitude = models.DecimalField(max_digits=9, decimal_places=6)
    longitude = models.DecimalField(max_digits=9, decimal_places=6)
    notes = models.TextField(blank=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        ordering = ['-start_time']

    def __str__(self):
        return f"{self.get_break_type_display()} - {self.start_time.date()}" 