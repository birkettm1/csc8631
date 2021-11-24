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

      [1]: 'Archtype (dfAR)'
      [2]: 'Enrollments (dfE)'
      [3]: 'Team Member (dfTM)'
      [4]: 'Leaving Survey (dfLSR)'
      [5]: 'Step Activity (dfSA)'
      [6]: 'Question Response (dfQR)'
      [7]: 'Video Stats (dfVS)'
      [8]: 'Sentiment Survey (dfSS)'
      ")
  
}






