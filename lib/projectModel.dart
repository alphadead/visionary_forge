class Project {
  final String? projectName;
  final String? description;
  final List<Milestone>? milestones;
  final int? progress;
  final double? budget;

  Project({
    this.projectName,
    this.description,
    this.milestones,
    this.progress,
    this.budget,
  });
}

class Milestone {
  final String? name;
  final DateTime? dueDate;

  Milestone({
    this.name,
    this.dueDate,
  });
}
