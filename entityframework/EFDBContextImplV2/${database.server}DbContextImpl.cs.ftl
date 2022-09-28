<#-- @ftlvariable name="table" type="bbd.jportal2.Table" -->
<#import "basefunctions.ftl" as base>
// ########################################################################################################################
// ################## Generated Code. DO NOT CHANGE THIS CODE. Change it in the generator and regenerate ##################
// ########################################################################################################################
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Diagnostics.CodeAnalysis;
using System.Linq;
using Bbd.Vanguard.${database.getServer()}.EntityFrameworkCore.Models;

namespace Bbd.Vanguard.${database.getServer()}.EntityFrameworkCore.${database.packageName}
{
    public partial class ${database.getServer()}DbContextImpl${database.packageName} : ${database.getServer()}DbContext
    {
        public ${database.getServer()}DbContextImpl${database.packageName}([NotNull] DbContextOptions<${database.getServer()}DbContextImpl${database.packageName}> options) : base(options) { }

        <#list database.getTables() as table>
        <#list table.procs as proc>
        <#if !proc.isStdExtended() && !proc.isSProc() && proc.name != "" && proc.name != "Identity" && proc.lines?size gt 0 && proc.outputs?size gt 0>
        private static string ${table.name}${proc.name}Statement = @"
<#list base.formatEFLines(proc.lines) as pl>
${pl}
</#list>
";
        public override IQueryable<${table.name}Entity_${proc.name}> ${table.name}Entity_${proc.name}(${base.getTypedFields(proc.inputs)})
            => ${table.name}_${proc.name}Set.FromSqlRaw(${table.name}${proc.name}Statement<#if proc.inputs?size gt 0>, </#if><#list proc.inputs as field>${field.name}<#compress><#sep>,</#compress></#list>);
        </#if>
        </#list>
        </#list>
    }
}