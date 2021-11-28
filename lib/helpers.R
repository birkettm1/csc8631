helper.function <- function()
{
  return(1)
}

as.percent = function(big, small){
  x = (small / 100)
  y = (x * big)
  return (as.integer(y))
}

#create the flow chart
create.erd.flowchart <- function()
{
  grViz("digraph flowchart {
      # node definitions with substituted label text
      node [fontname = Helvetica, shape = rectangle]        
      tab1 [label = '@@1']
      tab2 [label = '@@2']
      tab3 [label = '@@3']
      tab4 [label = '@@4']
      tab5 [label = '@@5']
      tab6 [label = '@@6']
      tab7 [label = '@@7']
      tab8 [label = '@@8']

      # edge definitions with the node IDs
      tab1 -> tab2;
      tab2 -> tab3;
      tab2 -> tab4;
      tab2 -> tab5;
      tab5 -> tab6;
      tab5 -> tab7;
      tab5 -> tab8;
      }

      [1]: 'Archtype'
      [2]: 'Enrollments'
      [3]: 'Team Member'
      [4]: 'Leaving Survey'
      [5]: 'Step Activity'
      [6]: 'Question Response'
      [7]: 'Video Stats'
      [8]: 'Sentiment Survey'
      ")
}

create.i2.erd.flowchart <- function()
{
  grViz("digraph flowchart {
      # node definitions with substituted label text
      node [fontname = Helvetica, shape = rectangle]        
      tab1 [label = '@@1']
      tab2 [label = '@@2']
      tab3 [label = '@@3']
      tab4 [label = '@@4']
      tab5 [label = '@@5']
      tab6 [label = '@@6']
      tab7 [label = '@@7']

      # edge definitions with the node IDs
      tab1 -> tab3;
      tab2 -> tab3;
      tab3 -> tab4;
      tab3 -> tab5;
      tab3 -> tab6;
      tab3 -> tab7;
      }

      [1]: 'Person'
      [2]: 'Student Info'
      [3]: 'Step'
      [4]: 'Answers'
      [5]: 'Video By Device (and pivot)'
      [6]: 'Video Views (and pivot)'
      [7]: 'Video By Location (and pivot)'
      [8]: 'Sentiment Survey'
      ")
  
}





