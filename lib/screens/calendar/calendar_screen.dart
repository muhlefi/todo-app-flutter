import 'package:flutter/material.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF00C853), // Green background
      appBar: AppBar(
        backgroundColor: const Color(0xFF00C853),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Add Calendar', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_horiz, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 24),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'March 2020',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.chevron_left, color: Colors.black45),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: const Icon(Icons.chevron_right, color: Colors.black45),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  // Days row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su'].map((day) {
                      return Text(
                        day,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),
                  
                  // Mockup dates row (Week 1)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: _buildDates(['31', '1', '2', '3', '4', '5', '6']),
                  ),
                  const SizedBox(height: 16),
                  // Mockup dates row (Week 2)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: _buildDates(['7', '8', '9', '10', '11', '12', '13']),
                  ),
                  const SizedBox(height: 16),
                  // Mockup dates row (Week 3)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: _buildDates(['14', '15', '16', '17', '18', '19', '20']),
                  ),
                  const SizedBox(height: 16),
                  
                  // Highlighted Week 4
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F5E9),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildDateItem('21', color: const Color(0xFF00C853)),
                        _buildDateItem('22', color: const Color(0xFF00C853)),
                        _buildDateItem('23', color: const Color(0xFF00C853)),
                        _buildDateItem('24', color: const Color(0xFF00C853)),
                        _buildDateItem('25', color: const Color(0xFF00C853)),
                        _buildDateItem('26', color: const Color(0xFF00C853)),
                        // Active Date
                        Container(
                          width: 32,
                          height: 32,
                          decoration: const BoxDecoration(
                            color: Color(0xFF00C853),
                            shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            '27',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Mockup dates row (Week 5)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: _buildDates(['28', '29', '30', '1', '2', '3', '4'], isFaded: true),
                  ),
                  
                  const SizedBox(height: 24),
                  const Divider(color: Colors.black12),
                  const SizedBox(height: 24),
                  
                  // Instant Section
                  const Text(
                    'Instant',
                    style: TextStyle(
                      color: Colors.black38,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildListItem(Icons.calendar_today_outlined, 'Today', 'Sat, 27 March'),
                  const SizedBox(height: 20),
                  _buildListItem(Icons.star_outline, 'Tomorrow', 'Sun, 28 March'),
                  
                  const SizedBox(height: 32),
                  const Text(
                    'Include',
                    style: TextStyle(
                      color: Colors.black38,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Icon(Icons.access_time, color: Colors.black45, size: 24),
                      const SizedBox(width: 16),
                      const Text(
                        'Add Time',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      const Icon(Icons.notifications_none, color: Colors.black45, size: 24),
                      const SizedBox(width: 16),
                      const Text(
                        'Reminder',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const Spacer(),
                      const Text(
                        'None',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black45,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.keyboard_arrow_down, color: Colors.black45),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildDates(List<String> dates, {bool isFaded = false}) {
    return dates.map((date) => _buildDateItem(date, isFaded: isFaded || (date.length == 1 && int.tryParse(date) != null && int.parse(date) > 7 && dates.last == '6'))).toList(); 
  }

  Widget _buildDateItem(String date, {bool isFaded = false, Color color = Colors.black45}) {
    return SizedBox(
      width: 32,
      height: 32,
      child: Center(
        child: Text(
          date,
          style: TextStyle(
            color: isFaded ? Colors.black26 : color,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildListItem(IconData icon, String title, String subtitle) {
    return Row(
      children: [
        Icon(icon, color: Colors.black45, size: 24),
        const SizedBox(width: 16),
        Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
        const SizedBox(width: 12),
        const Text(
          '•',
          style: TextStyle(color: Colors.black38),
        ),
        const SizedBox(width: 12),
        Text(
          subtitle,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Colors.black38,
          ),
        ),
      ],
    );
  }
}
